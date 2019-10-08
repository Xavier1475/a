<?php

namespace FactelBundle\Entity;

use Doctrine\ORM\Mapping as ORM;
use Knp\DoctrineBehaviors\Model as ORMBehaviors;

/**
 * TipoCuenta
 *
 * @ORM\Table()
 * @ORM\Entity(repositoryClass="FactelBundle\Entity\TipoCuentaRepository")
 */
class TipoCuenta
{
    use ORMBehaviors\Timestampable\Timestampable,
    ORMBehaviors\Blameable\Blameable
;
    /**
     * @var integer
     *
     * @ORM\Column(name="id", type="integer")
     * @ORM\Id
     * @ORM\GeneratedValue(strategy="AUTO")
     */
    private $id;

    /**
     * @var string
     *
     * @ORM\Column(name="nombreCuenta", type="string", length=100)
     */
    private $nombreCuenta;

    
    /**
     * @ORM\OneToMany(targetEntity="PlanCuentas", mappedBy="tipocuenta")
     */
    protected $planes;



    /**
     * Constructor
     */
    public function __construct() {
        $this->planes = new \Doctrine\Common\Collections\ArrayCollection();
     
    }

    /**
     * Add planes
     *
     * @param \FactelBundle\Entity\PlanCuentas $planes
     * @return TipoCuenta
     */
    public function addPlanes(\FactelBundle\Entity\PlanCuentas $planes) {
        $this->planes[] = $planes;

        return $this;
    }

    /**
     * Remove planes
     *
     * @param \FactelBundle\Entity\PlanCuentas $planes
     */
    public function removePlanes(\FactelBundle\Entity\PlanCuentas $planes) {
        $this->planes->removeElement($planes);
    }

    /**
     * Get planes
     *
     * @return \Doctrine\Common\Collections\Collection 
     */
    public function getPlanes() {
        return $this->planes;
    }

    /**
     * Get id
     *
     * @return integer
     */
    public function getId()
    {
        return $this->id;
    }

    /**
     * Set nombreCuenta
     *
     * @param string $nombreCuenta
     *
     * @return TipoCuenta
     */
    public function setNombreCuenta($nombreCuenta)
    {
        $this->nombreCuenta = $nombreCuenta;

        return $this;
    }

    /**
     * Get nombreCuenta
     *
     * @return string
     */
    public function getNombreCuenta()
    {
        return $this->nombreCuenta;
    }
}

