<?php

namespace FactelBundle\Entity;

use Doctrine\ORM\Mapping as ORM;

/**
 * PlanCuentas
 *
 * @ORM\Table()
 * @ORM\Entity(repositoryClass="FactelBundle\Entity\PlanCtasRepository")
 */
class PlanCuentas
{
    
    
    /**
     * @var integer
     *
     * @ORM\Column(name="id", type="integer")
     * @ORM\Id
     * @ORM\GeneratedValue(strategy="AUTO")
     */
    private $id;

    /**
     * @ORM\ManyToOne(targetEntity="Emisor", inversedBy="planes")
     * @ORM\JoinColumn(name="idempresa", referencedColumnName="id", nullable=false)
     */
    protected $idempresa;

    /**
     * @var integer
     *
     * @ORM\Column(name="codCta", type="integer")
     */
    private $codCta;

    /**
     * @ORM\ManyToOne(targetEntity="TipoCuenta", inversedBy="planes")
     * @ORM\JoinColumn(name="tipoCta", referencedColumnName="id", nullable=false)
     */
    protected $tipoCta;
    
    /**
     * @ORM\ManyToOne(targetEntity="Moneda", inversedBy="planes")
     * @ORM\JoinColumn(name="codMoneda", referencedColumnName="id", nullable=false)
     */
    protected $codMoneda;

    /**
     * @var string
     *
     * @ORM\Column(name="flujoCaja", type="string", length=100)
     */
    private $flujoCaja;

    /**
     * @var string
     *
     * @ORM\Column(name="bansel", type="string", length=50)
     */
    private $bansel;

    /**
     * @ORM\ManyToOne(targetEntity="Grupo", inversedBy="planes")
     * @ORM\JoinColumn(name="grupo", referencedColumnName="id", nullable=false)
     */
    protected $grupo;

    /**
     * @ORM\ManyToOne(targetEntity="User", inversedBy="planes")
     * @ORM\JoinColumn(name="codUsu", referencedColumnName="id", nullable=false)
     */
    protected $codUsu;

    /**
     * @var \DateTime
     *
     * @ORM\Column(name="fechaCreacion", type="date")
     */
    private $fechaCreacion;


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
     * Set idempresa
     *
     * @param \FactelBundle\Entity\Emisor $idempresa
     * @return PlanCuentas
     */
    public function setIdempresa(\FactelBundle\Entity\Emisor $idempresa) {
        $this->idempresa = $idempresa;

        return $this;
    }

    /**
     * Get idempresa
     *
     * @return \FactelBundle\Entity\Emisor
     */
    public function getIdempresa()
    {
        return $this->idempresa;
    }

    /**
     * Set codCta
     *
     * @param integer $codCta
     *
     * @return PlanCuentas
     */
    public function setCodCta($codCta)
    {
        $this->codCta = $codCta;

        return $this;
    }

    /**
     * Get codCta
     *
     * @return integer
     */
    public function getCodCta()
    {
        return $this->codCta;
    }

    
    /**
     * Set tipoCta
     *
     * @param \FactelBundle\Entity\TipoCuenta $tipoCta
     * @return PlanCuentas
     */
    public function setTipoCta(\FactelBundle\Entity\TipoCuenta $tipoCta) {
        $this->tipoCta = $tipoCta;

        return $this;
    }

    /**
     * Get tipoCta
     *
     * @return \FactelBundle\Entity\TipoCuenta 
     */
    public function getTipoCta() {
        return $this->tipoCta;
    }

    /**
     * Set codMoneda
     *
     * @param \FactelBundle\Entity\Moneda $codMoneda
     * @return PlanCuentas
     */
    public function setCodMoneda(\FactelBundle\Entity\Moneda $codMoneda) {
        $this->codMoneda = $codMoneda;

        return $this;
    }
    

    /**
     * Get codMoneda
     *
     * @return \FactelBundle\Entity\Moneda 
     */
    public function getCodMoneda() {
        return $this->codMoneda;
    }

    /**
     * Set flujoCaja
     *
     * @param string $flujoCaja
     *
     * @return PlanCuentas
     */
    public function setFlujoCaja($flujoCaja)
    {
        $this->flujoCaja = $flujoCaja;

        return $this;
    }

    /**
     * Get flujoCaja
     *
     * @return string
     */
    public function getFlujoCaja()
    {
        return $this->flujoCaja;
    }

    /**
     * Set bansel
     *
     * @param string $bansel
     *
     * @return PlanCuentas
     */
    public function setBansel($bansel)
    {
        $this->bansel = $bansel;

        return $this;
    }

    /**
     * Get bansel
     *
     * @return string
     */
    public function getBansel()
    {
        return $this->bansel;
    }

    /**
     * Set grupo
     *
     * @param \FactelBundle\Entity\Grupo $grupo
     * @return PlanCuentas
     */
    public function setGrupo(\FactelBundle\Entity\Grupo $grupo) {
        $this->grupo = $grupo;

        return $this;
    }

    /**
     * Get grupo
     *
     * @return \FactelBundle\Entity\Grupo 
     */
    public function getGrupo()
    {
        return $this->grupo;
    }

    /**
     * Set codUsu
     *
     * @param \FactelBundle\Entity\User $codUsu
     * @return PlanCuentas
     */
    public function setCodUsu(\FactelBundle\Entity\User $codUsu) {
        $this->codUsu = $codUsu;

        return $this;
    }

    /**
     * Get codUsu
     *
     * @return \FactelBundle\Entity\User 
     */
    public function getCodUsu() {
        return $this->codUsu;
    }

    /**
     * Set fechaCreacion
     *
     * @param \DateTime $fechaCreacion
     *
     * @return PlanCuentas
     */
    public function setFechaCreacion($fechaCreacion)
    {
        $this->fechaCreacion = $fechaCreacion;

        return $this;
    }

    /**
     * Get fechaCreacion
     *
     * @return \DateTime
     */
    public function getFechaCreacion()
    {
        return $this->fechaCreacion;
    }
}

