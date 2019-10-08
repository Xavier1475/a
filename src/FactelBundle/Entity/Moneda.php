<?php

namespace FactelBundle\Entity;

use Doctrine\ORM\Mapping as ORM;
use Knp\DoctrineBehaviors\Model as ORMBehaviors;

/**
 * Moneda
 *
 * @ORM\Table()
 * @ORM\Entity(repositoryClass="FactelBundle\Entity\MonedaRepository")
 */
class Moneda
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
     * @ORM\Column(name="nombMoneda", type="string", length=100)
     */
    private $nombMoneda;

    /**
     * @var integer
     *
     * @ORM\Column(name="valor", type="integer")
     */
    private $valor;

    /**
     * @ORM\OneToMany(targetEntity="PlanCuentas", mappedBy="moneda")
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
     * @return Moneda
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
     * Set nombMoneda
     *
     * @param string $nombMoneda
     *
     * @return Moneda
     */
    public function setNombMoneda($nombMoneda)
    {
        $this->nombMoneda = $nombMoneda;

        return $this;
    }

    /**
     * Get nombMoneda
     *
     * @return string
     */
    public function getNombMoneda()
    {
        return $this->nombMoneda;
    }

    /**
     * Set valor
     *
     * @param integer $valor
     *
     * @return Moneda
     */
    public function setValor($valor)
    {
        $this->valor = $valor;

        return $this;
    }

    /**
     * Get valor
     *
     * @return integer
     */
    public function getValor()
    {
        return $this->valor;
    }
}

